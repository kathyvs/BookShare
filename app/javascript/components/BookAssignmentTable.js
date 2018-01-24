import React from "react"
import PropTypes from "prop-types"
import BookAssignmentRow from "./BookAssignmentRow"

class BookAssignmentTable extends React.Component {
  render () {
    return (
      <table className="table table-hover table-responsive">
        <thead className="thead-dark">
          <tr>
            <th className="description">Book</th>
            <th className="need">Number still needed</th>
            <th className="bringing">Currently bringing</th>
          </tr>
        </thead>
        <tbody>
          {this.props.assignments.map(assignment => (
            <BookAssignmentRow key={assignment.book.key} assignment={assignment}/>
          ))}
        </tbody>
      </table>
    );
  }
}

BookAssignmentTable.propTypes = {
  assignments: PropTypes.array
};
export default BookAssignmentTable
