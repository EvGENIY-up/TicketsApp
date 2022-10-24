import axios from "axios";
import React from "react";
import Orderinfo from "./OrderInfo";

function Modal({ id, setModalOpened, title, description, dates, adult_price, kid_price }) {

    const [isDoubleRoute, setIsDoubleRoute] = React.useState(false);
    const [times, setTimes] = React.useState([]);
    const [secondTimes, setSecondTimes] = React.useState([]);
    const [orderInfo, setOrderInfo] = React.useState(false);
    const [orderValues, setOrderValues] = React.useState({});
    const [modalBtn, setModalBtn] = React.useState(true)
    const filterTimes = (event) => {
        let filteredDates = [];
        let filteredSecondDates = [];
        switch (event.target.value) {
            case '2':
                filteredDates = dates.filter((item) => item.route === 1);
                filteredSecondDates = dates.filter((item) => item.route === 0);
                break;
            case '0':
                filteredDates = dates.filter((item) => item.route === 1);
                console.log(filteredDates);
               
                break;
            case '1':
                filteredDates = dates.filter((item) => item.route === 0);
                console.log(filteredDates);
                break;
            default:
                break;
        }
        setIsDoubleRoute((Number(event.target.value) > 1) ? true : false)
        setTimes(filteredDates);
        setSecondTimes(filteredSecondDates);
    } 
    const filterSecondTimesByFirst = (event) => {
        const firstTime = new Date(event.target.value);
        console.log(secondTimes);
        setSecondTimes(secondTimes.filter((item) => new Date(item.time) > firstTime));
    } 
    const handleSubmit = (event) => {
        event.preventDefault();
        const requestBody = {};
        let route ="0";
        const formData = new FormData(event.currentTarget);
        formData.forEach((value, property) => requestBody[property] = value);
        requestBody['event_id'] = id;
        requestBody['ticket_adult_price'] = adult_price;
        requestBody['ticket_kid_price'] = kid_price;
        let data = new Date().toLocaleString();
        requestBody['created_time'] = data;
        requestBody['group_ticket'] === 'on' ? requestBody['group_ticket'] = 1 : requestBody['group_ticket'] = 0;
        requestBody['preferential_ticket'] === 'on' ? requestBody['preferential_ticket'] = 1 : requestBody['preferential_ticket'] = 0;
        if (requestBody['ticket_adult_quanity'] > 20 ) {
            alert('Максимальное кол-ва взрослых билетов равно 20')
            return;
        }
        if (requestBody['ticket_kid_quanity'] > 20 ) {
            alert('Максимальное кол-ва детских билетов равно 20')
            return;
        }
        if (requestBody['event_date_forward'] > requestBody['event_date_back'] ) {
            alert('Время отытия не может быть больше времени прибытия')
            return;
        }
        if (requestBody['route'] === "0") { 
            route = "Из A в B"
        }
        else if (requestBody['route'] === "1"){
            route = "Из B в A"
        }
        else {
            route = "из A в B и обратно в А"
        }
        const adultPrice = Number(adult_price)
        const adultTickets = Number(requestBody['ticket_adult_quanity'])
        const kidPrice = Number(kid_price)
        const kidTickets = Number(requestBody['ticket_kid_quanity'])
        const fullPrice = (adultPrice * adultTickets) + (kidPrice * kidTickets)
        requestBody['equal_price'] = fullPrice;
        let orderInformatinon = {
            adultPrice: adult_price,
            kidPrice: kid_price,
            kidTickets: kidTickets,
            adultTickets: adultTickets,
            fullPrice: fullPrice,
            route: route,
            firstRoute: requestBody['event_date_forward'],
            secondRoute: requestBody['event_date_back'],
        }
        delete requestBody.route
        console.log(requestBody)
        const jsonToSend = JSON.stringify(requestBody);
        axios.post('http://ticketsapp/api/create.php',  jsonToSend).then(
            setOrderValues(orderInformatinon),
            setOrderInfo(true),
            setModalBtn(false)
        )
    } 
    
    return (
        <div className="overlay">
            <div className="modal">
                <form onSubmit={handleSubmit}>
                <h2 value={id} className="modal__title">{title}<img onClick={() =>setModalOpened(false)} className="remove-btn" src="/img/close.svg" alt="Закрыть" />
                </h2>
                <p className="description">{description}</p>
                <div className="content">
                        <div className="content__choice">
                            <label className="checked width__modal">Выберите маршрут</label>
                            <select onChange={filterTimes} className="width__modal"  name="route" id="route" required>
                                <option value="0">из A в B</option>
                                <option value="1">из B в A</option>
                                <option value="2">из A в B и обратно в А</option>
                            </select>
                            <label className="checked width__modal" >Выберите время</label>
                            <select onChange={filterSecondTimesByFirst} className="width__modal" name="event_date_forward" id="event_date_forward" required>
                                {times.map((item, index) =>
                                    <option key={index} value={`${item.time}`}>{item.time}</option>
                                )}
                            </select>
                            
                            {isDoubleRoute &&
                            <>
                                <label className="checked width__modal" >Выберите время обратного пути</label>
                                <select className="width__modal" name="event_date_back" id="event_date_back">
                                    {secondTimes.map((item, index) =>
                                        <option key={index} value={`${item.time}`}>{item.time}</option>
                                    )}
                                </select>
                            </>
                            }
                            <label className="checked width__modal">Количество взрослых билетов "max20"</label>
                            <input className="width__modal" name="ticket_adult_quanity" id="ticket_adult_quanity" required pattern="^[ 0-9]+$"></input>
                            <label className="checked width__modal">Количество детских билетов "max20"</label>
                            <input className="width__modal" name="ticket_kid_quanity"id="ticket_kid_quanity" required pattern="^[ 0-9]+$"></input>
                        </div>
                        <div className="content__price">
                            <label className="price-ticket">Цена взрослого билета</label>
                            <p className="adult__price">{adult_price} Р</p>
                            <label className="price-ticket">Цена детского билета</label>
                            <p className="kid__price">{kid_price} Р</p>
                            <div className="checkbox">
                                <label className="">Групповой блиет</label>
                                <input type="checkbox" className="preferential_ticket" name="group_ticket" id="group_ticket"></input>
                            </div>
                            <div className="checkbox">
                                <label className="">Льготный билет </label>
                                <input type="checkbox" className="preferential_ticket" name="preferential_ticket"id="preferential_ticket" ></input>
                            </div>
                        </div>
                    </div>
                    {modalBtn && <button type="sumbit" className="modal-btn" required>Посчитать</button>}
                   { orderInfo &&  <Orderinfo orderValues={orderValues} setModalOpened={setModalOpened} />}
                </form>
                
            </div>
        </div>
    )
}

export default Modal;