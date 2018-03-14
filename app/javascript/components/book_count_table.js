import React from "react"
import PropTypes from "prop-types"
import BookShareTable, {utils} from "./book_share_table"

class BookCountTable extends React.Component  {

  render() {
    const columns = [{
      dataField: 'book.author',
      text: 'Author',
      classes: "author"
    }, {
      dataField: 'book',
      text: 'Book',
      classes: "description",
      formatter: utils.bookDescription
    }, {
      dataField: '1',
      text: 'Number requested',
      classes: "need",
    }];
    return(<BookShareTable
      data={this.props.counts}
      columns={columns}
      book='0'
      caption={this.props.caption}/>);
  }
}

BookCountTable.propTypes = {
  //caption: PropTypes.string.isRequired,
  counts: PropTypes.array.isRequired
};

export default BookCountTable
