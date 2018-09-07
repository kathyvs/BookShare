import React from "react"
import PropTypes from "prop-types"
import BookShareTable, {utils} from "./book_share_table"

/**
 * Component to display the requested number of books for a single event.
 */
class BookCountTable extends React.Component  {

  renderCount(form_name, count, book, row_index) {
    const id = form_name + "_counts_" + row_index;
    const name = form_name + "[counts][" + book.key + "]";
    return(<input id={id} type="text"
        name={name} defaultValue={count}/>);
  }

  buildCaption(event_name) {
    return "Books for " + (event_name || "New Event");
  }

  render() {
    const needColumn = {dataField: '1',
      text: 'Number requested',
      classes: "need"};
    if (this.props.editable) {
      needColumn.formatter = (count, row, row_index) =>
        this.renderCount(this.props.form_name, count, row.book, row_index);
    }
    const columns = [{
      dataField: 'book.author',
      text: 'Author',
      classes: "author"
    }, {
      dataField: 'book',
      text: 'Book',
      classes: "description",
      formatter: utils.bookDescription
    },
    needColumn];
    const caption = this.props.caption || this.buildCaption(this.props.event_name)

    return(<BookShareTable
      data={this.props.counts}
      columns={columns}
      book='0'
      caption={caption}/>);
  }
}

BookCountTable.propTypes = {
  editable: PropTypes.bool,
  event_name: PropTypes.string,
  counts: PropTypes.array.isRequired,
  caption: PropTypes.string
};

export default BookCountTable
