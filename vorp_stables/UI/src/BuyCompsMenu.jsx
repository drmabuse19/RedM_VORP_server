import { useContext, useEffect, useState } from "react";
import { Data, RouteCtx } from "./App";
import axios from "axios";

function BuyCompsMenu({ Comps, buyable, horseId }) {
  const [viewType, setViewType] = useState(null);
  const [model, setModel] = useState(null);
  const setRoute = useContext(RouteCtx);
  useEffect(() => {
    if (model !== null)
      axios.post(`https://${GetParentResourceName()}/viewComp`, {
        modelHash: model.variants[model.v],
        type: viewType,
      });
  }, [model])
  useEffect(() => {
    document.onkeydown = (e) => {
      if (e.key === "Backspace") {
        setModel(null);
        !viewType ? setRoute("/myrides") : setViewType(null)
      }

      else if (e.key === "ArrowLeft" && model) {
        setModel(m => {
          m.v = m.v === 0 ? m.variants.length - 2 : m.v - 1;
          return { ...m };
        }
        )
      }
      else if (e.key === "ArrowRight" && model) {
        setModel(m => {
          m.v = m.v === m.variants.length - 2 ? 0 : m.v + 1;
          return { ...m };
        }
        )
      }
    }
  })

  return (
    <div className="menu-wrap">
      <h1>{viewType ? Object.keys(Comps).find((name) => Comps[name] === viewType) : "Équipement"}</h1>
      <menu>
        {
          viewType === null
            ? Object.entries(Comps).map(([compType, compModels]) =>
              !Object.values(compModels).every((variants) => variants.length === 0) &&
              <span key={compType} onClick={() => setViewType({...compModels, type: compType})}>{compType}</span>
            )
            : Object.entries(viewType).map(([modelName, variants]) =>
              variants.length > 0 && modelName !== "type" && 
              <span key={modelName} onClick={() => { setModel({ name: modelName, variants, v: 0 }) }}>
                <label>{modelName} {modelName === model?.name ? "◄ " + model.v + " ►" : null}</label>
                <button onClick={() => {
                  if(!model) return;
                  axios.post(`https://${GetParentResourceName()}/buyComp`, {
                    compType: viewType.type,
                    compModel: variants[model.v],
                    price: buyable ? variants.at(-1) : 0,
                    horseId
                  })
                }}>{buyable ? Data.Lang.BuyFor.replace("{price}", variants.at(-1)) : Data.Lang.Equip}</button>
              </span>
            )
        }
      </menu>
    </div>
  )
}

export default BuyCompsMenu;