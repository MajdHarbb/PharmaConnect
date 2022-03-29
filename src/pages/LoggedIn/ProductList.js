import { Link } from "react-router-dom";
import "../../css/ProductsList.css";
import { DataGrid } from "@mui/x-data-grid";
import { DeleteOutline } from "@material-ui/icons";
import { productRows } from "../../Data/DummyData.js";
import { useState , useEffect} from "react";
import axios from "axios";

export default function ProductList() {

  var access_token=localStorage.getItem("access_token");
  const AuthStr = 'Bearer '.concat(access_token); 
  var patients = [];
  //var [data, setData] = useState([]);


  useEffect(() => {
    axios.get("http://127.0.0.1:8000/api/admin/get-all-patients", { headers: { Authorization: AuthStr } })
   .then(response => {
       // If request is good...
       patients = JSON.stringify(response.data);
       patients = JSON.parse(patients)
       //setData(patients);
       console.log(patients)
      
    })
   .catch((error) => {
       console.log('error ' + error);
    });
  },[]);

    const [data, setData] = useState(productRows);
  
    const handleDelete = (id) => {
      setData(data.filter((item) => item.id !== id));
    };
  
    const columns = [
      { field: "id", headerName: "ID", width: 90 },
      {
        field: "product",
        headerName: "Product",
        width: 200,
        renderCell: (params) => {
          return (
            <div className="productListItem">
              <img className="productListImg" src={params.row.img} alt="" />
              {params.row.name}
            </div>
          );
        },
      },
      { field: "stock", headerName: "Stock", width: 200 },
      {
        field: "status",
        headerName: "Status",
        width: 120,
      },
      {
        field: "price",
        headerName: "Price",
        width: 160,
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