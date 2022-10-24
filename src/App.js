import React from "react";
import Ticket from "./components/Ticket";
import axios from "axios";

  

function App() {
   const [data, setData] = React.useState([]);

    React.useEffect(()=>{
        (async () => {
            const { data } = await axios.get('http://ticketsapp/api/events.php');
          setData(data.data);
          console.log(data.data);
        })();
    }, []);
  
  return (
    <div className="App">
      <div className="wrapper">
        {data.map((item, index) => (
          <Ticket
            key={index}
            {...item}
          />))
        }
      </div>
    </div>
  );
}

export default App;
