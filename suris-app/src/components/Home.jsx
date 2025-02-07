import React from "react";
import { Link } from "react-router";

function Home () {
    return (
    <>
    <h1>Bienvenido a Suris Code!</h1>
    <h2>Damos vida a tus productos y ayudamos a que tu negocio escale</h2>
    <div className="card">
      <Link to="/reservas">
      <button className="home-button">
        Reserva una reunión con nosotros!
      </button>
      </Link>
      <Link to="/confirmaciones">
      <button className="home-button">
        Busca tus reservas
      </button>
      </Link>
    </div>
  </>
  )
}

export default Home;