import React from 'react';
import './Radio.css';

class Radio extends React.Component {
	render() {
		return (
			<div className="radio">
				<label
					htmlFor={this.props.htmlFor}
					label={this.props.label}
				>
					<input
						type="radio"
						name={this.props.name || null}
						id={this.props.htmlFor}
						required={this.props.required || null}
					/>
					{this.props.label}
				</label>
			</div>
		);
	}
}

export default Radio;