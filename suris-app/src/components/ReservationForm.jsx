import React, {useEffect, useState} from "react";
import { getAllReservations, getAllServices, addNewReservation } from "../services/reservationServices";
import { useNavigate } from "react-router";
import { Formik, Field, Form, ErrorMessage } from "formik";
import * as Yup from "yup";
import DatePicker from 'react-datepicker';
import "react-datepicker/dist/react-datepicker.css";

function ReservationForm () {
  const [existingReservations, setExistingReservations] = useState([])
  const [services, setServices] = useState([])
  const navigate = useNavigate();

  const fetchExistingReservations = async () =>{
    const data = await getAllReservations();
    if(data){
      setExistingReservations(data)
    } else console.log("ERROR: fetchExistingReservations")
  }

  const fetchAllServices = async () =>{
    const data = await getAllServices();
    if(data){
      setServices(data)
    } else console.log("ERROR: fetchAllServices")
  }

  useEffect(()=>{
    fetchExistingReservations()
    fetchAllServices()
  },[])

  const handleSubmit = async (values) => {
    const { fullName, serviceId, date } = values;
    const adjustedDate = new Date(date.getTime() - 3 * 60 * 60 * 1000);
    const formattedDate = adjustedDate.toISOString()

    const payload = {
      client: fullName,
      serviceId: parseInt(serviceId),
      dateTime: formattedDate,
    };
    
    console.log(payload, "Payload");
    const res = await addNewReservation(payload);
    if (res) {
      navigate("/confirmaciones", { state: payload.client });
    } else {
      alert("Error al crear la reserva, por favor intenta nuevamente.");
    }
  };

  const isTimeAvailable = (date) => {
    return !existingReservations.some((res) => {
      const reservationDateTime = new Date(res.dateTime);
      return (
        reservationDateTime.getFullYear() === date.getFullYear() &&
        reservationDateTime.getMonth() === date.getMonth() &&
        reservationDateTime.getDate() === date.getDate() &&
        reservationDateTime.getHours() === date.getHours()
      );
    });
  };

  const filterDate = (date, fullName) => {
    const day = date.getDay();
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const isDayReservedByClient = existingReservations.some((res) => {
      const reservationDate = new Date(res.dateTime);
      reservationDate.setHours(0, 0, 0, 0);

      return (
        reservationDate.getTime() === date.getTime() &&
        res.client === fullName
      );
    });

    return day >= 1 && day <= 5 && date >= today && !isDayReservedByClient;
  };

  const validationSchema = Yup.object({
    fullName: Yup.string().required("Precisamos tu nombre completo"),
    serviceId: Yup.string().required("Selecciona un servicio"),
    date: Yup.date().nullable().required("Selecciona una fecha y hora válida"),
  });

  return (
    <>
      <h1>Reserva una reunión con nosotros!</h1>

      <Formik
        initialValues={{
          fullName: "",
          serviceId: "",
          date: null,
        }}
        validationSchema={validationSchema}
        onSubmit={handleSubmit}
      >
        {({ setFieldValue, values, errors, touched }) => (
          <Form>
            <div>
              <label htmlFor="fullName">Nombre completo:</label>
              <Field
                type="text"
                id="fullName"
                name="fullName"
                value={values.fullName}
                className={touched.fullName && errors.fullName ? "error" : ""}
              />
              <ErrorMessage name="fullName" component="div" className="error-message" />
            </div>

            <div>
              <label htmlFor="serviceId">Servicio:</label>
              <Field
                as="select"
                id="serviceId"
                name="serviceId"
                value={values.serviceId}
                className={touched.serviceId && errors.serviceId ? "error" : ""}
              >
                <option value="">Selecciona un servicio</option>
                {services.map((service) => (
                  <option key={service.id} value={service.id}>
                    {service.name}
                  </option>
                ))}
              </Field>
              <ErrorMessage name="serviceId" component="div" className="error-message" />
            </div>

            <div>
              <label htmlFor="date">Fecha y hora:</label>
              <DatePicker
                selected={values.date}
                onChange={(date) => setFieldValue("date", date)}
                onChangeRaw={(e) => e.preventDefault()}
                showTimeSelect
                timeIntervals={60}
                minTime={new Date(new Date().setHours(9, 0, 0))}
                maxTime={new Date(new Date().setHours(17, 0, 0))}
                filterDate={(date) => filterDate(date, values.fullName)}
                filterTime={isTimeAvailable}
                dateFormat="yyyy-MM-dd h:mm aa"
                placeholderText="Selecciona una fecha"
                strictParsing
              />
              <ErrorMessage name="date" component="div" className="error-message" />
            </div>

            <button type="submit">Reservar</button>
          </Form>
        )}
      </Formik>
    </>
  );
};

export default ReservationForm;