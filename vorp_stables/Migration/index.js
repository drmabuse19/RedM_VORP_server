const knex = require('knex')({
  client: 'mysql2',
  connection: {
    host : 'YOUR_ENDPOINT or localhost',
    port : 3306,
    user : 'Your DB user',
    password : 'Your DB Password',
    database : 'vorpv2'
  }
});

async function getInvs() {

  const chars = await knex("characters").select("identifier", "charidentifier");
  const charIndices = {};
  for (const char of chars) charIndices[char.charidentifier] = char.identifier;
  const Items = await knex("items").select();
  const invs = await knex("stables")
  .whereNot("inventory", null)
  .select("inventory", "id", "charidentifier", "name")

  for (const inv of invs) {
    let items = JSON.parse(inv.inventory);
    const id = inv.id;
    const charId = inv.charidentifier;
    const rideName = inv.name;

    for(const item of items) {
      
      if(item.type == "item_standard") {
        const itemId = Items.find(i => i.item === item.name)?.id;
        if(!itemId) {
          console.log("Item not found : " + item.name)
          continue
        }
        await knex("items_crafted").insert({
          id: item.id,
          character_id: item.owner || charId,
          item_id: itemId,
          metadata: JSON.stringify(item.metadata) || "{}"
        }).catch(e => {});
        await knex("character_inventories").insert({
          character_id: item.owner,
          inventory_type: rideName,
          item_crafted_id: item.id,
          amount: item.count,
        }).catch(e => {});
      }
      else if (item.type == "item_weapon") {
        await knex("loadout").where("id", item.id).update({
          curr_inv: rideName
        })
      }
    }
    //console.log(items);
  }
}

getInvs();
