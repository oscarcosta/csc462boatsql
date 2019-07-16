import React from 'react';
import Radio from "./Radio";

class DBRadio extends React.Component {
	render() {
		const name = this.props.name;
		const choice = this.props.choice
		const onChange = (e) => this.props.onChange(e);
		return (
			<div className="db-selector">
				<h3>Select Database: </h3>
				<fieldset >
					<Radio
						name={name}
						value="sql"
						label="MySQL"
						required={true}
						selected={choice === "sql"}
						onChange={onChange}
					/>
					<Radio
						name={name}
						value="mongo"
						label="MongoDB"
						required={true}
						selected={choice === "mongo"}
						onChange={onChange}	
					/>
					<Radio
						name={name}
						value="both"
						label="Both (Performance Comparison)"
						required={true}
						selected={choice === "both"}
						onChange={onChange}
					/>
				</fieldset>
			</div>
		);
	}
}

export default DBRadio;