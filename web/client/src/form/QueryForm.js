import React from 'react';
import DBRadio from '../elements/DBRadio';
import {AxesFields, LabelledRange} from "../elements/AxesFields";
import Input from "../elements/Input";
import './QueryForm.css';

class QueryForm extends React.Component {

	constructor(props) {
		super(props);
		this.state = {
			heading: '',
			specHeading: '',
			features: "",
			gcmna: "",
			location: "",
			category: "",
			material: "",
			manufacturer: "",
			dbChoice: 'sql',
		};

		this.handleChange = this.handleChange.bind(this);
		this.handleSubmit = this.handleSubmit.bind(this);
	}
	handleChange(event) {
		this.setState({
			[event.target.name]: event.target.value
		});
	}
	handleSubmit(event) {
		// alert("Submitted: " + JSON.stringify(this.state));
		event.preventDefault();
	}

	render() {
		return (
			<form onSubmit={this.handleSubmit}>
				<DBRadio
					name="dbChoice"
					choice={this.state.dbChoice}
					onChange={this.handleChange}
				/>
				<div className="textFields">
					<Input
						name="heading"
						label="Heading:"
						value={this.state.heading}
						onChange={this.handleChange}
					/>
					<Input
						name="specHeading"
						label="Spec Heading:"
						value={this.state.specHeading}
						onChange={this.handleChange}
					/>
					<Input
						name="gcmna"
						label="GCMNA Point Person:"
						value={this.state.gcmna}
						onChange={this.handleChange}
					/>
					<Input
						name="features"
						label="Features (Comma separated):"
						value={this.state.features}
						onChange={this.handleChange}
					/>
					<Input
						name="location"
						label="Location:"
						value={this.state.location}
						onChange={this.handleChange}
					/>
					<Input
						name="category"
						label="Category:"
						value={this.state.category}
						onChange={this.handleChange}
					/>
					<Input
						name="material"
						label="Material / Colour:"
						value={this.state.material}
						onChange={this.handleChange}
					/>
					<Input
						name="manufacturer"
						label="Manufacturer:"
						value={this.state.manufacturer}
						onChange={this.handleChange}
					/>
					<LabelledRange
						name="weight-one"
						label="Weight Per Unit"
					/>
					<LabelledRange
						name="quantity"
						label="Quantity"
					/>
				</div>

				<AxesFields
					value={this.state.axes}
					onChange={this.state.handleChange}
				/>
				<input type="submit" value="Submit"/>
			</form>
		);
	}
}
export default QueryForm;