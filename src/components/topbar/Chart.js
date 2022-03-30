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

export default function Chart({ title, grid }) {

  var access_token=localStorage.getItem("access_token");
  const AuthStr = 'Bearer '.concat(access_token); 
  var governates = [];
  var [data2, setData] = useState(null);
  const [isLoading,setLoading] = useState(false);


  useEffect(() => {
    axios.get("http://127.0.0.1:8000/api/admin/finds-governates", { headers: { Authorization: AuthStr } })
   .then(response => {
       // If request is good...
       console.log(response.data)
       governates = JSON.stringify(response.data);
       governates = JSON.parse(governates)
       setData(governates);

       //matching the graph's input: 
      var x = [
      {"Governate": "Akkar", "Medications Found": governates["Akkar"]},
      {"Governate": "Baalbek", "Medications Found": governates["Baalbek"]},
      {"Governate": "Beirut", "Medications Found": governates["Beirut"]},
      {"Governate": "Beqaa", "Medications Found": governates["Beqaa"]},
      {"Governate": "Mount Lebanon", "Medications Found": governates["Mount Lebanon"]},
      {"Governate": "Nabatieh", "Medications Found": governates["Nabatieh"]},
      {"Governate": "North Governate", "Medications Found": governates["North Governate"]},
      {"Governate": "South Governate", "Medications Found": governates["South Governate"]},];
      
      console.log(x)
      setData(x);
      //now render the actual component
      setLoading(true);
       
    })
   .catch((error) => {
       console.log('error ' + error);
    });
  },[]);


  if(isLoading){
    return (
    
      <div className="chart">
        <h3 className="chartTitle">{title}</h3>
        <ResponsiveContainer width="100%" aspect={4 / 1}>
          <LineChart data={data2}>
            <XAxis dataKey="Governate" stroke="#5550bd" />
            <Line type="monotone" dataKey="Medications Found" stroke="#5550bd" />
            <Tooltip />
            {grid && <CartesianGrid stroke="#e0dfdf" strokeDasharray="5 5" />}
          </LineChart>
        </ResponsiveContainer>
      </div>
    );
  }else{
    return (
      <div className="chart">
        <div>Loading</div>
      </div>
    );
  }
  
}
