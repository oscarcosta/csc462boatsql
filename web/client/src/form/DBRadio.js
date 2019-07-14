import React from 'react';
import Radio from "./Radio";

class DBRadio extends React.Component {
	render() {
		return (
			<div className="db-choice">
				<h3>Select Database: </h3>
				<fieldset >
					<Radio
						htmlFor="radio-sql"
						name="db-choice"
						label="MySQL"
						required="true"
					/>
					<Radio
						htmlFor="radio-mongo"
						name="db-choice"
						label="MongoDB"
						required="true"
					/>
					<Radio
						htmlFor="radio-both"
						name="db-choice"
						label="Both (Performance Comparison)"
						required="true"
					/>
				</fieldset>
			</div>
		);
	}
}

export default DBRadio;