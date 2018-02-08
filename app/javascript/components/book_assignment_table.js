import React from "react"
import PropTypes from "prop-types"
import BookAssignmentRow from "./book-assignment-row"

class BookAssignmentTable extends React.Component {
  render () {
    const columns = [];
    return (
      <table className="table table-hover table-responsive">
        <caption>{this.props.caption}</caption>
        <thead className="thead-dark">
          <tr>
            <th className="description" scope="col" colSpan="2">Book</th>
            <th className="need" scope="col">Number still needed</th>
            <th className="bringing" scope="col">Currently bringing</th>
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
  caption: PropTypes.string.isRequired,
  assignments: PropTypes.array.isRequired
};
export default BookAssignmentTable
