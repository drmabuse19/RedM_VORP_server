import { useContext, useEffect, useState } from "react";
import { Data, RouteCtx } from "./App";
import axios from "axios";

function TransferRecieve({ rideId, rideName, giverId, characters, price }) {

  const setRoute = useContext(RouteCtx);

  const giver = characters.find(c => c.charidentifier == giverId);
  const giverName = giver.firstname + " " + giver.lastname;

  useEffect(() => {
    document.onkeydown = (e) => {

    }
  }, [])

  return <div className="menu-wrap">
    <div className="modal-bg">
      <div className="modal">
        <h3>{Data.Lang.TransferRecap.replace("{playerName}", giverName).replace("{rideName}", rideName).replace("{price}", price)}</h3>
        <span>
          <button onClick={() => {
            axios.post(`https://${GetParentResourceName()}/transferRecieve`, {
              state: true,
              rideId,
              price
            });
            setRoute("/");
          }}>{Data.Lang.Accept}</button>
          <button onClick={() => { 
            axios.post(`https://${GetParentResourceName()}/transferRecieve`, {
              state: false,
              rideId
            });
            setRoute("/");
             }}>{Data.Lang.Refuse}</button>
        </span>
      </div>
    </div>



  </div>

}

export default TransferRecieve;