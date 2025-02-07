import React, {useEffect, useState} from "react";
import { getClientReservations } from "../services/reservationServices";
import { useLocation } from "react-router";
import { Formik, Field, Form, ErrorMessage } from "formik";
import * as Yup from "yup";

function ConfirmedReservations () {
  const [existingReservations, setExistingReservations] = useState([])
  const [clientName, setClientName] = useState("")
  const location = useLocation();
  const client = location.state

  const fetchClientReservations = async (clientName) => {
    const data = await getClientReservations(clientName);
    if (data.length > 0) {
      setClientName(clientName)
      setExistingReservations(data);
    } else if (data.length === 0) {
      alert("No se encontraron Registros asociados a " + clientName);
    } else console.log("ERROR: fetchClientReservations");
  };

  useEffect(() => {
    if (client) {
      console.log("Client Name", client);
      fetchClientReservations(client);
    }
  }, [client]);

  const handleReset = () => {
    setClientName("")
    setExistingReservations([])
  }

  const handleSubmit = (values) => {
    if (values.clientName) {
      fetchClientReservations(values.clientName);
    } else {
      alert("Por favor, ingresa tu nombre completo.");
    }
  };

  const validationSchema = Yup.object({
    clientName: Yup.string().required("Por favor, ingresa tu nombre completo."),
  });

  const mapCards = (reservations) =>{
    const cards = reservations.map((reservation) => (
      <div key={reservation.id} className="reservation-card">
        <h3>{reservation.service.name}</h3>
        <p><strong>Fecha y hora: <br/> </strong> {new Date(reservation.dateTime).toLocaleString()}</p>
      </div>
    ))
    return cards
  }

  return (
    <>
      {clientName && existingReservations.length > 0 ? (
        <>
          <h1>Estas son tus solicitudes, {clientName}! <br/>Cuentas con {existingReservations.length} reserva{existingReservations.length > 1 ? "s" : ""}</h1>
          <div className="card-container">
          {mapCards(existingReservations)}
          </div>
          
          <button type="button" className="home-button" onClick={handleReset}>Quieres buscar por otro nombre?</button>

        </>
      ) : (
        <>
          <h1>Busca tus solicitudes!</h1>
          <Formik
            initialValues={{ clientName: "" }}
            validationSchema={validationSchema}
            onSubmit={handleSubmit}
          >
            {({ values, handleChange, errors, touched }) => (
              <Form>
                <div>
                  <label htmlFor="clientName">Nombre completo:</label>
                  <Field
                    type="text"
                    id="clientName"
                    name="clientName"
                    value={values.clientName}
                    onChange={handleChange}
                    className={touched.clientName && errors.clientName ? "error" : ""}
                  />
                  <ErrorMessage name="clientName" component="div" className="error-message" />
                </div>
                <button type="submit" className="submit-button">Buscar</button>
              </Form>
            )}
          </Formik>
        </>
      )}
    </>
  );
}

export default ConfirmedReservations;