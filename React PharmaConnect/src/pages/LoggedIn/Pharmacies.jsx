import { Link } from "react-router-dom";
import "../../css/Pharmacy.css";
import Chart from "../../components/topbar/Chart";
import { productData } from "../../Data/DummyData";
import { Publish } from "@material-ui/icons";
import { Navigate } from "react-router-dom";
import { useState, useEffect } from "react";
import { useNavigate, useParams } from "react-router-dom";
import axios from "axios";

export default function Pharmacy() {
  var emailRegex =
    /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
  var phoneRegex = /^[0-9]{8}$/;

  const navigate = useNavigate();

  //params to get user id
  const params = useParams();
  //get token from local storage
  var access_token = localStorage.getItem("access_token");
  const AuthStr = "Bearer ".concat(access_token);
  var user_info = [];

  const [email, setEmail] = useState("");
  const [name, setName] = useState("");
  const [phone, setPhone] = useState("");

  var [data, setData] = useState([]);
  var [profile_pic, setProfile] = useState(
    "defualt_profile_picture_pharmaConnect.png"
  );
  const [p, setP] = useState("defualt_profile_picture_pharmaConnect.png");
  //state that is to be set to true when api is fetched
  const [isLoading, setLoading] = useState(false);

  //fetch pha
  useEffect(() => {
    axios
      .get(`http://127.0.0.1:8000/api/admin/pharmacy-info?user_id=1`, {
        headers: { Authorization: AuthStr },
      })
      .then((response) => {
        console.log("response", response.data);
        user_info = response.data;
        setData(user_info[0]);

        setLoading(true);
      })
      .catch((error) => {
        console.log("error " + error);
      });
  }, []);
  if (isLoading) {
    return (
      <div className="product">
        <div className="productTitleContainer">
          <h1 className="productTitle">Pharmacy</h1>
          <Link to="/newproduct">
            <button className="productAddButton">Create</button>
          </Link>
        </div>
        <div className="productTop">
          <div className="productTopLeft">
            <Chart
              data={productData}
              dataKey="Sales"
              title="Medication Finds Distribution"
            />
          </div>
          <div className="productTopRight">
            <div>
              <div className="productInfoTop">
                <img
                  className="productInfoImg"
                  src={`http://127.0.0.1:8000/profiles/${
                    data["profile_pic"]
                  }?v=${Math.round(Date.now() / 1000)}`}
                />
                <span className="productName">{data["name"]}</span>
              </div>

              <div className="productInfoBottom">
                <div className="productInfoItem">
                  <span className="productInfoKey">id:</span>
                  <span className="productInfoValue">123</span>
                </div>
                <div className="productInfoItem">
                  <span className="productInfoKey">email: {"   "} </span>
                  <span className="productInfoValue">{data["email"]}</span>
                </div>
                <div className="productInfoItem">
                  <span className="productInfoKey">Phone</span>
                  <span className="productInfoValue">{data["phone"]}</span>
                </div>
                <div className="productInfoItem">
                  <span className="productInfoKey">in stock:</span>
                  <span className="productInfoValue">no</span>
                </div>
                <div className="productInfoItem">
                  <span className="productInfoKey">in stock:</span>
                  <span className="productInfoValue">no</span>
                </div>
                <div className="productInfoItem">
                  <span className="productInfoKey">in stock:</span>
                  <span className="productInfoValue">no</span>
                </div>
              </div>
            </div>
            <div>
              <div className="productUpload">
                <img
                  className="productUploadImg"
                  src={`http://127.0.0.1:8000/licenses/${
                    data["license"]
                  }?v=${Math.round(Date.now() / 1000)}`}
                />

                <p>Click to view license</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  } else {
    return (
      <div>
        <h1>Loading</h1>
      </div>
    );
  }
}
