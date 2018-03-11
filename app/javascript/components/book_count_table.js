import React from "react"
import PropTypes from "prop-types"
import BookShareTable from "./book_share_table"

class BookCountTable extends React.Component  {

  render() {
    return(<BookShareTable data={this.props.counts} book='0' caption={this.props.caption}/>);
  }
}

BookCountTable.propTypes = {
  //caption: PropTypes.string.isRequired,
  counts: PropTypes.array.isRequired
};

export default BookCountTable
