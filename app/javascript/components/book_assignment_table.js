import React from "react"
import ReactDOMServer from 'react-dom/server';
import PropTypes from "prop-types"
import BookShareTable, {utils} from "./book_share_table"

class BookAssignmentTable extends React.Component {

  generalAssignmentFormatter(profileAssignments) {
    return(<ul>{profileAssignments.map((pair) => (
      <li key={id_of(pair.profile)}><NameAndCount
        profile={pair.profile}
        count={pair.count}/></li>))}</ul>);
  }

  render () {
    const columns = [{
      dataField: 'book.author',
      text: 'Author',
      classes: 'author',
      headerClasses: 'author col-sm-2'
     },{
      dataField: 'book',
      text: 'Title',
      classes: "description",
      headerClasses: 'description col-sm-8',
      formatter: utils.bookDescription
    }, {
      dataField: 'needs',
      text: 'Number still needed',
      classes: "need",
      headerClasses: 'need'
    }, {
      dataField: 'profile_assignments',
      text: 'Currently bringing',
      classes: "bringing",
      headerClasses: 'bringing col-sm-3',
      formatter: this.generalAssignmentFormatter
    }
    ];
    return (
      <BookShareTable data={this.props.assignments}
        book="book"
        columns = {columns}
        caption={this.props.caption}/>
    );
  }
}

BookAssignmentTable.propTypes = {
  caption: PropTypes.string.isRequired,
  assignments: PropTypes.array.isRequired
};

function NameAndCount ( {profile, count} ) {
 const countString = count > 1 ? ` (${count})` : "";
  return (<span>{profile.name}{countString}</span>);
}

NameAndCount.propTypes = {
  profile: PropTypes.shape({
    _id: PropTypes.object,
    name: PropTypes.string.isRequired,
  }),
  count: PropTypes.number
}

function id_of(obj) {
  return obj._id['$oid']
}


export default BookAssignmentTable
