import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faStar, faLocationDot, faWifi, faPersonSwimming, faHeart } from "@fortawesome/free-solid-svg-icons";
import axios from "axios";
import React, { useState, useEffect, useMemo, useContext } from "react";
import "../styles/cards.css";
import { Link } from "react-router-dom";
import { useAccordionButton, Card } from "react-bootstrap";
import Accordion from 'react-bootstrap/Accordion'


const CardRecomendacion = ({ selectCiudad, selectCategoria, startDate, endDate }) => {
    const [dataProducto, setDataProducto] = useState([]);
    const [dataImagen, setImagen] = useState([]);
    const [dataCaracteristicas, setCaracteristicas] = useState([]);
    const [idProducto, setIdProducto] = useState([]);
    const [verMas, setVerMas] = useState(false);

    const fechaInicio = new Date(startDate).toISOString().slice(0, 10);
    const fechaFinal = new Date(endDate).toISOString().slice(0, 10);

    const getUrl = () => selectCiudad ? `http://remo-digitalbooking-env-prod.eba-xby23mds.us-west-1.elasticbeanstalk.com/productos/FiltroPorCiudadYFechas/${selectCiudad}/${fechaInicio}/${fechaFinal}` : "http://remo-digitalbooking-env-prod.eba-xby23mds.us-west-1.elasticbeanstalk.com/productos/traerTodos";


    useEffect(() => {
        axios.get(getUrl())
            .then(response => {
                setDataProducto(response.data)
            })
        // TODO Modificar url
        axios.get(`http://localhost:8080/imagenes/listarImagenes`)
            .then(response => {
                setImagen(response.data)
            })

    }, [selectCiudad, startDate, endDate])

    console.log(startDate);
    useEffect(() => {
        axios.get(`http://localhost:8080/caracteristicas/listarCaracteristicas`)
            .then(response => {
                setCaracteristicas(response.data)
            })
    }, [])


    const getImage = (card) => {
        const imagenes = dataImagen.filter((img) => img.producto?.id == card.id);
        //console.log("imagenes: ", imagenes);
        return imagenes[0]?.url
    }

    /*     const getCaracteristicas = (card) =>{
            const caracteristicas = dataCaracteristicas.filter((c) => c.producto?.id == card.id);
            return caracteristicas      
        } */


    const filteredList = useMemo(() => {

        return selectCategoria ? dataProducto.filter((prod) => prod.categoria.id == selectCategoria) : dataProducto;


    }, [dataProducto, selectCategoria, selectCiudad])


    //const getFilteredList = () => selectCiudad ? dataProducto.filter((prod) => prod.ciudad.id == selectCiudad) : dataProducto;

    //const getFilteredCategoryList = () => selectCategoria ? dataProducto.filter((prod) => prod.categoria.id == selectCategoria) : dataProducto;

    return (
        <div className="cards">
            {(filteredList?.map((card) => (
                <div key={card.id} className="cardRecomendacion">
                    <div style={{ backgroundImage: "url('" + getImage(card) + "')" }} className="fondoImagen" />
                    <div className="cardBody">
                        <div className="presentacion">
                            <div>
                                <p className="hotel">{card.categoria.titulo} <FontAwesomeIcon icon={faStar} className="estrella" /><FontAwesomeIcon icon={faStar} className="estrella" /><FontAwesomeIcon icon={faStar} className="estrella" /><FontAwesomeIcon icon={faStar} className="estrella" /><FontAwesomeIcon icon={faStar} className="estrella" /></p>
                                <h3 className="nombreHotel">{card.nombre}</h3>
                            </div>
                            <div className="calificacion">
                                <span className="puntaje">8</span>
                                <p style={{ fontWeight: "700" }}>Muy Bueno</p>
                            </div>
                        </div>
                        <div className="infoHotel">
                            <p><FontAwesomeIcon icon={faLocationDot} style={{ marginRight: "4px" }} />{card.ciudad.nombre} <span className="mostrarMapa">MOSTRAR EN EL MAPA</span></p>
                            <p className="iconosInfoHotel">
                                {dataCaracteristicas.filter((c) => c.producto?.id == card.id)
                                    .map((cat) => (
                                        <span class="material-symbols-outlined">{cat.icono}</span>
                                    ))}
                            </p>
                        </div>
                        <p>{verMas ? card.descripcion : card.descripcion.split(' ', 8).join(" ")}<span className="mas" onClick={() => setVerMas(!verMas)}>
                            {verMas ? " ver menos" : " ver más..."}</span></p>
                        <Link to={`/productos/${card.id}`}><button className="buttonCard">ver más</button></Link>
                    </div>
                </div>
            )))}
        </div>
    )


}
export default CardRecomendacion;


