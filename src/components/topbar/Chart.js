import "../../css/Chart.css";
import { useState ,useEffect } from "react";
import axios from "axios";
import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
} from "recharts";
const data = [
  {
    "name": "Jan",
    "Active User": "4000",
    
  },
  {
    "name": "Feb",
    "Active User": "3000",
  },
  {
    "name": "Mar",
    "Active User": "5000",
  },
  {
    "name": "Apr",
    "Active User": "0",
  },
  {
    "name": "May",
    "Active User": "3000",
  },
  {
    "name": "Jun",
    "Active User": "2000",
  },
  {
    "name": "Jul",
    "Active User": "4000",
  },

];
export default function Chart({ title, grid }) {

  var access_token=localStorage.getItem("access_token");
  const AuthStr = 'Bearer '.concat(access_token); 
  var governates = [];
  var [data2, setData] = useState([]);


  useEffect(() => {
    axios.get("http://127.0.0.1:8000/api/admin/finds-governates", { headers: { Authorization: AuthStr } })
   .then(response => {
       // If request is good...
       console.log(response.data)
       governates = JSON.stringify(response.data);
       governates = JSON.parse(governates)
       setData(governates);
      //  console.log(governates["Akkar"]);
      var x = [
      {"Governate": "Akkar", "Medications Found": governates["Akkar"]},
      {"Governate": "Baalbek", "Medications Found": governates["Baalbek"]},
      {"Governate": "Beirut", "Medications Found": governates["Beirut"]},
      {"Governate": "Beqaa", "Medications Found": governates["Beqaa"]},
      {"Governate": "Mount Lebanon", "Medications Found": governates["Mount Lebanon"]},
      {"Governate": "Nabatieh", "Medications Found": governates["Nabatieh"]},
      {"Governate": "North Governate", "Medications Found": governates["North Governate"]},
      {"Governate": "South Governate", "Medications Found": governates["South Governate"]},];
      var stringified = JSON.stringify(x);
      console.log("stringified "+ stringified)
      
      setData(stringified);
      console.log(stringified)
      // var parssed = JSON.parse(stringified);
      //   console.log("parsed "+parssed)
      // //  console.log(JSON.stringify(x));
      // //  console.log(JSON.parse(x))
       
    })
   .catch((error) => {
       console.log('error ' + error);
    });
  },[]);

  var test = [{"governate": "value" , "found medication": "2000"}];
  //console.log(test["governate"])

  return (
    <div className="chart">
      <h3 className="chartTitle">{title}</h3>
      <ResponsiveContainer width="100%" aspect={4 / 1}>
        <LineChart data={data}>
          <XAxis dataKey="name" stroke="#5550bd" />
          <Line type="monotone" dataKey="Active User" stroke="#5550bd" />
          <Tooltip />
          {grid && <CartesianGrid stroke="#e0dfdf" strokeDasharray="5 5" />}
        </LineChart>
      </ResponsiveContainer>
    </div>
  );
}
