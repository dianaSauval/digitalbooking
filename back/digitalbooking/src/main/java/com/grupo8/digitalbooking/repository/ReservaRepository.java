package com.grupo8.digitalbooking.repository;

import com.grupo8.digitalbooking.model.Reserva;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

public interface ReservaRepository extends JpaRepository<Reserva, Integer> {
    //HQL


    public List<Reserva> findByBetweenFechaInicialAndFechaFinal(LocalDate fechaInicial, LocalDate fechaFinal);
}
