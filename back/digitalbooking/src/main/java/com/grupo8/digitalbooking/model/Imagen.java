package com.grupo8.digitalbooking.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;

@ToString
@Getter
@Setter

@Entity
@Table(name = "imagenes")
public class Imagen {
    @Id
    @SequenceGenerator(name = "imagenes_sequence", sequenceName = "imagenes_sequence", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "imagenes_sequence")
    private Integer id;
    private String nombre;
    private String URL;

    @JsonIgnore
    @JsonIgnoreProperties(value = {"hibernateLazyInitializer","handler"})
    @ManyToOne()
    @JoinColumn(name = "producto_id")
    private Producto producto;


    public Imagen(Integer id, String nombre, String URL) {
        this.id = id;
        this.nombre = nombre;
        this.URL = URL;
    }

    public Imagen(String nombre, String URL) {
        this.nombre = nombre;
        this.URL = URL;
    }

    public Imagen() {
    }
}