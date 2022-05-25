import React from 'react';
import "./input.css"
import { Component } from "react";

const Input = ({attribute, handleChange, param})=>{
    return(
        <div className='input-contenedor'>
            <input
            id={attribute.id}
            name={attribute.name}
            placeholder={attribute.placeholder}
            type={attribute.type}
            onChange={(e)=>handleChange(e.target.name, e.target.value)}
            className="regular-style"></input>
        </div>
    )
};

export default Input;
