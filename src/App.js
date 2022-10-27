import React from "react";
import Ticket from "./components/Ticket";
import axios from "axios";

  

function App() {
   const [data, setData] = React.useState([]);

    React.useEffect(()=>{
        async function fetchData() {
          try {
            const { data } = await axios.get('http://ticketsapp/api/events.php');
            setData(data.data);
          } catch (error) {
            alert('Ошибка при получении контента с сервера')
          }
        };
        fetchData();
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
