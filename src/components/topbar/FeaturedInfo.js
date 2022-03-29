import "../../css/FeaturedInfo.css";
import { ArrowDownward, ArrowUpward, Person, LocalPharmacyRounded, PostAdd } from "@material-ui/icons";
import { useState ,useEffect } from "react";
import axios from "axios";


export default function FeaturedInfo() {
  var access_token=localStorage.getItem("access_token");
  const AuthStr = 'Bearer '.concat(access_token); 
  var pharmacies = [];
  var [data, setData] = useState([]);


  useEffect(() => {
    axios.get("http://127.0.0.1:8000/api/admin/counts", { headers: { Authorization: AuthStr } })
   .then(response => {
       // If request is good...
       pharmacies = JSON.stringify(response.data);
       pharmacies = JSON.parse(pharmacies)
       console.log(pharmacies)
       setData(pharmacies);
      
    })
   .catch((error) => {
       console.log('error ' + error);
    });
  },[]);
  return (
    <div className="featured">
      <div className="featuredItem">
        <span className="featuredTitle">Users</span>
        <div className="featuredMoneyContainer">
          <span className="featuredMoney">{data["users"]}</span>
          <span className="featuredMoneyRate">
            <Person className="featuredIcon" />
          </span>
        </div>
        <span className="featuredSub">Patients & Pharmacies</span>
      </div>
      <div className="featuredItem">
        <span className="featuredTitle">Pharmacies</span>
        <div className="featuredMoneyContainer">
          <span className="featuredMoney">{data["pharmacies"]}</span>
          <span className="featuredMoneyRate">
            <LocalPharmacyRounded className="featuredIcon" />
          </span>
        </div>
        <span className="featuredSub">Contributing Pharmacies With PharmaConnect</span>
      </div>
      <div className="featuredItem">
        <span className="featuredTitle">Medicine Posts</span>
        <div className="featuredMoneyContainer">
          <span className="featuredMoney">{data["posts"]}</span>
          <span className="featuredMoneyRate">
            <PostAdd className="featuredIcon" />
          </span>
        </div>
        <span className="featuredSub">Posts searching for medication</span>
      </div>
    </div>
  );
}
