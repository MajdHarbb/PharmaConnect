import { Link } from "react-router-dom";
import "../../css/PharmaciesList.css";
import { DataGrid } from "@mui/x-data-grid";
import { DeleteOutline } from "@material-ui/icons";
import { useState, useEffect } from "react";
import axios from "axios";

export default function PharmacyList() {
  //get token from storage
  var access_token = localStorage.getItem("access_token");
  const AuthStr = "Bearer ".concat(access_token);
  var pharmacies = [];
  var [data, setData] = useState([]);

  //fetch pharmacies
  useEffect(() => {
    axios
      .get("http://127.0.0.1:8000/api/admin/get-all-pharmacies", {
        headers: { Authorization: AuthStr },
      })
      .then((response) => {
        // If request is good...
        pharmacies = JSON.stringify(response.data);
        pharmacies = JSON.parse(pharmacies);
        console.log(pharmacies);
        setData(pharmacies);
      })
      .catch((error) => {
        console.log("error " + error);
      });
  }, []);

  const handleDelete = (id) => {
    setData(data.filter((item) => item.id !== id));
  };

  const columns = [
    { field: "id", headerName: "ID", width: 20 },
    {
      field: "pharmacy name",
      headerName: "Pharmacy Name",
      width: 200,
      renderCell: (params) => {
        return (
          <div className="productListItem">
            <img
              className="productListImg"
              src={`http://127.0.0.1:8000/profiles/${
                params.row.profile_pic
              }?v=${Math.round(Date.now() / 1000)}`}
            />

            {params.row.name}
          </div>
        );
      },
    },
    { field: "email", headerName: "Email", width: 200 },
    {
      field: "Governate",
      headerName: "Governate",
      width: 120,
      renderCell: (params) => {
        return <div className="productListItem">{params.row.district}</div>;
      },
    },
    {
      field: "locality",
      headerName: "locality",
      width: 120,
      renderCell: (params) => {
        return <div className="productListItem">{params.row.locality}</div>;
      },
    },
    {
      field: "street",
      headerName: "Street",
      width: 120,
      renderCell: (params) => {
        return <div className="productListItem">{params.row.street}</div>;
      },
    },
    {
      field: "License",
      headerName: "License",
      width: 120,
      renderCell: (params) => {
        return (
          <div className="productListItem">
            <img
              className="productListImg"
              src={`http://127.0.0.1:8000/licenses/${
                params.row.license
              }?v=${Math.round(Date.now() / 1000)}`}
            />
          </div>
        );
      },
    },
    {
      field: "action",
      headerName: "Action",
      width: 150,
      renderCell: (params) => {
        return (
          <>
            <Link to={"" + params.row.id}>
              <button className="productListEdit">Edit</button>
            </Link>
            <DeleteOutline
              className="productListDelete"
              onClick={() => handleDelete(params.row.id)}
            />
          </>
        );
      },
    },
  ];

  return (
    <div className="productList">
      <DataGrid
        rows={data}
        disableSelectionOnClick
        columns={columns}
        pageSize={8}
        checkboxSelection
      />
    </div>
  );
}
