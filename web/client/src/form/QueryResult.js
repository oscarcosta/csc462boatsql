import React from 'react';
import './QueryResult.css';

class QueryResult extends React.Component {
	render() {
		return (
			<div className="QueryResult">{this.props.result}</div>
		);
	}
}
export default QueryResult;