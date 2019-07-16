import React from 'react'
import './AxesFields.css';

class AxesFields extends React.Component {
	render() {
		return (
			<table className="axes-fields">
				<thead>
					<tr>
						<th></th>
						<th>Longitudinal</th>
						<th>Transverse</th>
						<th>Vertical</th>
					</tr>
				</thead>
				<tbody className="axis-fields">
					<tr>
						<th>Center of Gravity</th>
						<Range wrapper="td" name="lcg" />
						<Range wrapper="td" name="tcg" />
						<Range wrapper="td" name="vcg" />
					</tr>
					<tr>
						<th>Moment of Inertia</th>
						<Range wrapper="td" name="lm" />
						<Range wrapper="td" name="tm" />
						<Range wrapper="td" name="vm" />
					</tr>
				</tbody>
			</table>
		);
	}
}
function Range(props) {
	const WrapperTag = (props.wrapper ? props.wrapper : "div");
	const name = props.name;
	return (
		<WrapperTag className="Range">
			<input type="number" name={name + "-min"} id={name + "-min"} /> to <input type="number" name={name + "-max"} id={name + "-max"}/>
		</WrapperTag>
	);
}
function LabelledRange(props) {
	const htmlFor = props.name + "-range";
	return(
		<div className="LabelledRange">
			<label htmlFor={htmlFor}>
				{props.label}
			</label>
			<Range name={props.name} />
		</div>
	);
}
export {
	AxesFields,
	Range,
	LabelledRange
};