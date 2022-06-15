package com.grupo8.digitalbooking.security;

import com.grupo8.digitalbooking.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfiguration;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {

    @Autowired
    UsuarioService usuarioService;

//    @Autowired
//    private UserDetailsService myUserDetailsService;
//
//    @Autowired
//    private JwtRequestFilter jwtRequestFilter;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

@Override
    protected void configure(HttpSecurity http) throws Exception{
http.csrf()
        .disable()
        .authorizeRequests()
        .antMatchers("/categorias/**")
        .hasAuthority("ADMIN")
//        .antMatchers( "/odontologos/**", "/pacientes/**")
//        .hasAuthority("ADMIN")
//        .antMatchers("/turnoAlta.html",
//                "/turnoList.html")
//        .hasAuthority("USER")
//        .antMatchers("/odontologoAlta.html",
//                "/pacienteAlta.html",
//                "/usuarioAdd.html",
//                "/odontologoList.html",
//                "/pacienteList.html")
//        .hasAuthority("ADMIN")
        .anyRequest().authenticated()
        .and()
        .formLogin()
        .permitAll()
        .and()
        .exceptionHandling().accessDeniedPage("/acceso_denegado.html");

}

@Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception{
    auth.authenticationProvider(daoAuthenticationProvider());
}
@Bean
    public DaoAuthenticationProvider daoAuthenticationProvider(){

    DaoAuthenticationProvider provider= new DaoAuthenticationProvider();
    provider.setPasswordEncoder(bCryptPasswordEncoder);
    provider.setUserDetailsService(usuarioService);
    return provider;
}


}
