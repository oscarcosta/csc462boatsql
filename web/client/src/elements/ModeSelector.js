import React from 'react';
import Radio from "./Radio";
import './ModeSelector.css';

function DBRadio(props) {
	const name = props.name;
	const choice = props.choice;
	const onChange = (e) => props.onChange(e);
	return (
		<div className="DBRadio">
			<Radio
				name={name}
				value="sql"
				label="MySQL"
				checked={choice === "sql"}
				onChange={onChange}
			/>
			<Radio
				name={name}
				value="mongo"
				label="MongoDB"
				checked={choice === "mongo"}
				onChange={onChange}
			/>
			<Radio
				name={name}
				value="both"
				label="Both (Performance Comparison)"
				checked={choice === "both"}
				onChange={onChange}
			/>
		</div>
	);
}

function ReadWriteRadio(props) {
	const name = props.name;
	const choice = props.choice;
	const onChange = (e) => props.onChange(e);
	return (
		<div className="ReadWriteRadio">
			<Radio
				name={name}
				value="read"
				label="Read"
				required={true}
				checked={choice === "read"}
				onChange={onChange}
			/>
			<Radio
				name={name}
				value="write"
				label="Write"
				required={true}
				checked={choice === "write"}
				onChange={onChange}
			/>
		</div>
	);
}

function ModeSelector(props) {
	// const onChange = (e) => props.onChange(e);
	return (
		<div className="ModeSelector">
			<DBRadio
				name="dbChoice"
				choice={props.choice}
				onChange={props.onChange}
			/>
			<ReadWriteRadio
				name="queryMode"
				choice={props.queryMode}
				onChange={props.onChange}
			/>
		</div>
	);
}
/**
 * Inputs: template
 * @param {*} props 
 */
function SourceSelector(props) {
	return (
		<div className="SourceSelector">
			<h3>Replace contents with template JSON:</h3>
			<div>
				<Radio
					name="template-select"
					value="parts"
					label="New Part"
					checked={props.templateChoice === "parts"}
					onChange={e => props.onTemplateChange("parts")}
				/>
				<Radio
					name="template-select"
					value="boatParts"
					label="New BoatPart"
					checked={props.templateChoice === "boatParts"}
					onChange={e => props.onTemplateChange("boatParts")}
				/>
			</div>
		</div>
	);
}
export {
	ModeSelector,
	SourceSelector
};