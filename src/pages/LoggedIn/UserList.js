import "../../css/UserList.css";
import { DataGrid } from "@mui/x-data-grid";
import { DeleteOutline } from "@material-ui/icons";
import { Link } from "react-router-dom";
import { useState ,useEffect } from "react";
import axios from "axios";
//import {access_token, AuthStr} from "../../constants/token"

export default function UserList() {


  var access_token=localStorage.getItem("access_token");
  const AuthStr = 'Bearer '.concat(access_token); 
  var patients = [];
  var [data, setData] = useState([]);

  

  useEffect(() => {
    axios.get("http://127.0.0.1:8000/api/admin/get-all-patients", { headers: { Authorization: AuthStr } })
   .then(response => {
       // If request is good...
       patients = JSON.stringify(response.data);
       patients = JSON.parse(patients)
       setData(patients);
       console.log(response.data)
      
    })
   .catch((error) => {
       console.log('error ' + error);
    });
  },[]);
  
  

  const handleDelete = (id) => {
    setData(data.filter((item) => item.id !== id));
  };

  const columns = [
    { field: "id", headerName: "ID", width: 90 },
    {
      field: "profile picture",
      headerName: "Profile Picture",
      width: 200,
      renderCell: (params) => {
        return (
          <div className="userListUser">
            <img className="userListImg" src={require("../../assets/profiles/"+params.row.profile_pic)} alt="" />
          </div>
        );
      },
    },
    {
      field: "name",
      headerName: "Name",
      width: 200,
      renderCell: (params) => {
        return (
          <div className="userListUser">
            {params.row.name}
          </div>
        );
      },
    },

    { field: "email", headerName: "Email", width: 200 },
    {
      field: "phone",
      headerName: "Phone",
      width: 120,
    },
    {
      field: "data created",
      headerName: "Joined At",
      width: 160,
    },
    {
      field: "action",
      headerName: "Action",
      width: 150,
      renderCell: (params) => {
        return (
          <>
            {/* <Link to={"user/" + params.row.id}>
              <button className="userListEdit">Edit</button>
            </Link> */}
            <Link to={"" + params.row.id}>
              <button className="userListEdit">Edit</button>
            </Link>
            <DeleteOutline
              className="userListDelete"
              onClick={() => handleDelete(params.row.id)}
            />
          </>
        );
      },
    },
  ];

  return (
    <div className="userList">
      <DataGrid
        rows={data}
        disableSelectionOnClick
        columns={columns}
        pageSize={10}
        checkboxSelection
      />
    </div>
  );
}
