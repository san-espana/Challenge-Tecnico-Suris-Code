import React from "react"
import {Route, Routes, BrowserRouter, useLocation } from "react-router"
import Home from './components/Home'
import NavBar from "./components/NavBar"
import ReservationForm from "./components/ReservationForm"
import ConfirmedReservations from "./components/ConfirmedReservations"
import './App.css'

function App() {
  return (
    <BrowserRouter>
    <NavBar />
      <Routes>
        <Route path="/" element={<Home/>}/>
        <Route path="/reservas" element={<ReservationForm/>}/>
        <Route path="/confirmaciones" element={<ConfirmedReservations/>}/>
      </Routes>    
    </BrowserRouter>
  )
}

export default App
