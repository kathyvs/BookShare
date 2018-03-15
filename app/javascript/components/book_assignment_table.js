import React from "react"
import ReactDOMServer from 'react-dom/server';
import PropTypes from "prop-types"
import BookShareTable, {utils} from "./book_share_table"

class BookAssignmentTable extends React.Component {

  generalAssignmentFormatter(profileAssignments) {
    return(profileAssignments.map((pair, index) => (
      <NameAndCount key={id_of(pair.profile)}
        profile={pair.profile}
        count={pair.count}
        index={index}/>)));
  }

  render () {
    const columns = [{
      dataField: 'book.author',
      text: 'Author',
      classes: 'description',
     },{
      dataField: 'book',
      text: 'Title',
      classes: "description",
      formatter: utils.bookDescription
    }, {
      dataField: 'needs',
      text: 'Number still needed',
      classes: "need"
    }, {
      dataField: 'profile_assignments',
      text: 'Currently bringing',
      classes: "bringing",
      formatter: this.generalAssignmentFormatter
    }
    ];
    return (
      <BookShareTable data={this.props.assignments}
        book="book"
        columns = {columns}
        caption={this.props.caption}/>
      // <table className="table table-hover table-responsive">
      //   <caption>{this.props.caption}</caption>
      //   <thead className="thead-dark">
      //     <tr>
      //       <th className="description" scope="col" colSpan="2">Book</th>
      //       <th className="need" scope="col">Number still needed</th>
      //       <th className="bringing" scope="col">Currently bringing</th>
      //     </tr>
      //   </thead>
      //   <tbody>
      //     {this.props.assignments.map(assignment => (
      //       <BookAssignmentRow key={assignment.book.key} assignment={assignment}/>
      //     ))}
      //   </tbody>
      // </table>
    );
  }
}

BookAssignmentTable.propTypes = {
  caption: PropTypes.string.isRequired,
  assignments: PropTypes.array.isRequired
};

function NameAndCount ( {profile, count, index} ) {
  const prefix = index > 0 && ", ";
  const countString = count > 1 ? ` (${count})` : "";
  return (<span>{prefix}{profile.name}{countString}</span>);
}

NameAndCount.propTypes = {
  profile: PropTypes.shape({
    _id: PropTypes.object,
    name: PropTypes.string.isRequired,
  }),
  count: PropTypes.number,
  index: PropTypes.number.isRequired
}

function id_of(obj) {
  return obj._id['$oid']
}


export default BookAssignmentTable
