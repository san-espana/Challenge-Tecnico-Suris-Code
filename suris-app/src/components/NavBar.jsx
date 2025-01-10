import React from 'react';
import { Link, useLocation } from 'react-router';

function NavBar() {
  const location = useLocation()
  
  return location.pathname !== "/" ? (
    <nav className="navbar">          
        <Link to="/">
            <button>Home</button>
        </Link>

        <Link to="/reservas">
            <button>Reservas</button>
        </Link>

        <Link to="/confirmaciones">
            <button>Confirmaciones</button>
        </Link>
    </nav>
  ) : null;
}

export default NavBar;
