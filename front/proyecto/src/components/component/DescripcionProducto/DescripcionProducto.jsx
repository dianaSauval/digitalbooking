import React, { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import axiosConnection from "../../../helpers/axiosConnection";
import "../Cards/cards.scss";

const DescripcionProducto = () => {
  const [dataDescripcion, setDataDescripcion] = useState([]);
  const { id } = useParams();
  useEffect(() => {
    axiosConnection
      .get(`http://localhost:8080/productos/buscarProductoPorId/${id}`)
      .then((response) => {
        setDataDescripcion(response.data);
      });
  }, []);

  return (
    <>
      <h2>{dataDescripcion.nombre}</h2>
      <p key={dataDescripcion.id}>{dataDescripcion.descripcion}</p>
    </>
  );
};

export default DescripcionProducto;
