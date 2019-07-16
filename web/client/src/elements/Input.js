import React from 'react'

export default function Input(props) {
	const type = props.type ? props.type : "text";
	const htmlFor = props.name + "-field";
	let className = "Input";
	if (props.className) {
		className += " " + props.className;
	}
	return(
		<div className={className}>
			<label htmlFor={htmlFor} className={className}>
				{props.label}
			</label>
			<input
				type={type}
				name={props.name}
				id={htmlFor}
				value={props.value}
				onChange={props.onChange}
			/>
		</div>
	);
}