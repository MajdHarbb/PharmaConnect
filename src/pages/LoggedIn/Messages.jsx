import React from 'react';
import "../../css/UserList.css";
import { DataGrid } from "@mui/x-data-grid";
import { DeleteOutline } from "@material-ui/icons";
import { Link } from "react-router-dom";
import { useState ,useEffect } from "react";
import axios from "axios";
const Messages = () => {
    var access_token=localStorage.getItem("access_token");
  const AuthStr = 'Bearer '.concat(access_token); 
  var patients = [];
  var [data, setData] = useState([]);
  let axiosConfig = {
    headers: {
      "Content-Type": "application/json;charset=UTF-8",
    },
  };


  useEffect(() => {
    axios.get("http://127.0.0.1:8000/api/admin/get-message", { headers: { Authorization: AuthStr } })
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

  const columns = [
    { field: "id", headerName: "ID", width: 90 },
    {
      field: "name",
      headerName: "Name",
      width: 200,
      renderCell: (params) => {
        return (
          <div className="userListUser">
           <img className="userListImg" src={`http://127.0.0.1:8000/profiles/${params.row.profile_pic}?v=${Math.round(Date.now() / 1000)}`} />

            {params.row.name}
          </div>
        );
      },
    },

    { field: "email", headerName: "Email", width: 200 },
    {
      field: "message_text",
      headerName: "Message",
      width: 350,
    },
    {
      field: "updated_at",
      headerName: "Date",
      width: 120,
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
};

export default Messages;