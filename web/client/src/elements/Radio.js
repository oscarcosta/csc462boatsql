import React from 'react';
import './Radio.css';

class Radio extends React.Component {
	constructor(props) {
		super(props);
		this.htmlFor = "radio-" + props.value;
	}
	render() {
		return (
			<div className="radio">
				<label
					htmlFor={this.htmlFor}
					label={this.props.label}
				>
					<input
						type="radio"
						name={this.props.name || null}
						id={this.htmlFor}
						value={this.props.value}
						required={this.props.required || null}
						onChange={this.props.onChange}
					/>
					{this.props.label}
				</label>
			</div>
		);
	}
}

export default Radio;