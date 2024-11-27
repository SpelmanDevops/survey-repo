import React, { useState } from "react";

function App() {
  const [response, setResponse] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();
    const res = await fetch("https://<function-app-url>/api/survey",{
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ response }),
    });
    const data = await res.json();
    alert(data.message);
  };

  return (
    <div>
      <h1>Survey</h1>
      <form onSubmit={handleSubmit}>
        <textarea
          placeholder="Enter your response"
          value={response}
          onChange={(e) => setResponse(e.target.value)}
        ></textarea>
        <button type="submit">Submit</button>
      </form>
    </div>
  );
}

export default App;
