import React from 'react';
import './App.css';
import QueryForm from './form/QueryForm';
import QueryResult from './form/QueryResult';

function App() {
	return (
		<div className="App">
			<header className="App-header">
				<h1>Boat Data Store Query App</h1>
			</header>
			<QueryForm />
			<QueryResult />
		</div>
	);
}

export default App;
