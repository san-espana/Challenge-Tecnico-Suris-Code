import React from 'react';
import { Link, useLocation } from 'react-router';

function NavBar() {
  const location = useLocation()
  
  return location.pathname !== "/" ? (
    <nav className="navbar">          
        <Link to="/">
            <button>Inicio</button>
        </Link>

        <Link to="/reservas">
            <button>Reservar</button>
        </Link>

        <Link to="/confirmaciones">
            <button>Ver Reservas</button>
        </Link>
    </nav>
  ) : null;
}

export default NavBar;
