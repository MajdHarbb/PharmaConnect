import "../../css/UserList.css";
import { DataGrid } from "@mui/x-data-grid";
import { DeleteOutline } from "@material-ui/icons";
import { userRows } from "../../Data/DummyData.js";
import { Link } from "react-router-dom";
import { useState ,useEffect } from "react";
import axios from "axios";

export default function UserList() {
  var access_token=localStorage.getItem("access_token");
  
  const AuthStr = 'Bearer '.concat(access_token); 
  var patients = [];
  var [data, setData] = useState();


  useEffect(() => {
    axios.get("http://127.0.0.1:8000/api/admin/get-all-patients", { headers: { Authorization: AuthStr } })
   .then(response => {
       // If request is good...
       //console.log(response.data);
       patients = JSON.stringify(response.data);
       patients = JSON.parse(patients)
       console.log(patients);
       
      
      
    })
   .catch((error) => {
       console.log('error ' + error);
    });
  });
  
  
  
  function setrows(){
    setData(patients)
  }
  
  
  

  const handleDelete = (id) => {
    setData(data.filter((item) => item.id !== id));
  };

  const columns = [
    { field: "id", headerName: "ID", width: 90 },
    {
      field: "user",
      headerName: "User",
      width: 200,
      renderCell: (params) => {
        return (
          <div className="userListUser">
            <img className="userListImg" src={params.row.avatar} alt="" />
            {params.row.username}
          </div>
        );
      },
    },
    { field: "email", headerName: "Email", width: 200 },
    {
      field: "status",
      headerName: "Status",
      width: 120,
    },
    {
      field: "transaction",
      headerName: "Transaction Volume",
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
        pageSize={100}
        checkboxSelection
      />
    </div>
  );
}
