import React from 'react';
import DBRadio from './DBRadio';
import './QueryForm.css';

class QueryForm extends React.Component {

	constructor(props) {
		super(props);
		this.state = {value: ''};

		this.handleChange = this.handleChange.bind(this);
		this.handleSubmit = this.handleSubmit.bind(this);
	}

	handleChange(event) {
		this.setState({value: event.target.value});
	}
	handleSubmit(event) {
		alert("Submitted: " + this.state.value);
		event.preventDefault();
	}

	render() {
		return (
			<form onSubmit={this.handleSubmit}>
				<DBRadio />
				<label htmlFor="name-field">Name:</label>
				<input
					type="text"
					name="name"
					id="name-field"
					value={this.state.value}
					onChange={this.handleChange}
				/>
				<input type="submit" value="Submit"/>
			</form>
		);
	}
}
class CenterFields extends React.Component {
	render() {
		return (
			<table className="axes-fields">
				<thead>
					<th>Longitudinal</th>
					<th>Transverse</th>
					<th>Vertical</th>
				</thead>
			</table>
		);
	}
}
export default QueryForm;