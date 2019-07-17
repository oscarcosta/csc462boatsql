import React from 'react';
import ReactJson from "react-json-view";
import './QueryResult.css';

class QueryResult extends React.Component {
	render() {
		return (
			<ReactJson src={this.props.result} />
			// <pre className="QueryResult">{this.props.result}</pre>
		);
	}
}
export default QueryResult;