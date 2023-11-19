import React, { useState, useEffect } from 'react';
import axios from 'axios';

function App() {
  const [items, setItems] = useState([]);
  const [itemName, setItemName] = useState('');
  const [itemDescription, setItemDescription] = useState('');

  useEffect(() => {
    axios.get('/api/items').then((response) => {
      setItems(response.data);
    });
  }, []);

  const addItem = () => {
    axios.post('/api/items', { name: itemName, description: itemDescription }).then((response) => {
      setItems([...items, response.data]);
    });
  };

  return (
    <div>
      <h1>Simple App</h1>
      <ul>
        {items.map((item) => (
          <li key={item._id}>
            {item.name} - {item.description}
          </li>
        ))}
      </ul>
      <div>
        <input type="text" placeholder="Name" value={itemName} onChange={(e) => setItemName(e.target.value)} />
        <input type="text" placeholder="Description" value={itemDescription} onChange={(e) => setItemDescription(e.target.value)} />
        <button onClick={addItem}>Add Item</button>
      </div>
    </div>
  );
}

export default App;
