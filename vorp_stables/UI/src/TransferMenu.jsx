import { useContext, useEffect, useState } from "react";
import { Data, RouteCtx } from "./App";
import axios from "axios";

function TransferModal({ rideId, rideName, characters }) {

  const setRoute = useContext(RouteCtx);
  const [matchingChars, setMatchingChars] = useState(characters);
  const [selectedChar, setSelectedChar] = useState(null);
  const [priceSel, setPriceSel] = useState(false);

  useEffect(() => {
    document.onkeydown = (e) => {

    }
  }, [])

  return <div className="menu-wrap">
    {
      priceSel
        ? <div className="modal-bg">
          <div className="modal">
            <h3>{Data.Lang.Transfer} {rideName} {Data.Lang.To} {matchingChars.find(c => c.charidentifier == selectedChar).firstname} {matchingChars.find(c => c.charidentifier == selectedChar).lastname}</h3>
            <input id="price" type="text" placeholder={Data.Lang.PricePlaceholder} key="price" />
            <span>
              <button onClick={() => {
                if (!selectedChar) return;
                const input = Number(document.querySelector('#price').value);
                const p = isNaN(input) ? 0 : input;
                axios.post(`https://${GetParentResourceName()}/transfer`, { rideId, selectedChar, price: p });
                setRoute("/");
              }}>{Data.Lang.Ok}</button>
              <button onClick={() => { setRoute("/myrides") }}>{Data.Lang.Cancel}</button>
            </span>
          </div>
        </div>


        : <div className="modal-bg">
          <div className="modal">
            <h3>{Data.Lang.Transfer} {rideName}</h3>
            <input id="search" type="text" key="search" placeholder={Data.Lang.NamePlaceholder} onChange={(e) => {
              setMatchingChars(cs =>
                [...cs.filter(c =>
                  `${c.firstname} ${c.lastname}`.toLowerCase()
                    .includes(e.target.value.toLocaleLowerCase()))
                ]
              )
            }} />
            <div className="char-list">
              {
                matchingChars.map(char => {
                  return <div className={"char " + (selectedChar == char.charidentifier ? "active" : "")} key={char.charidentifier} onClick={() => setSelectedChar(char.charidentifier)}>{char.firstname} {char.lastname}</div>
                })
              }
            </div>
            <span>
              <button onClick={() => {
                if (!selectedChar) return;
                setPriceSel(true);
              }}>{Data.Lang.Ok}</button>
              <button onClick={() => { setRoute("/myrides") }}>{Data.Lang.Cancel}</button>
            </span>
          </div>
        </div>
    }
  </div>

}

export default TransferModal;