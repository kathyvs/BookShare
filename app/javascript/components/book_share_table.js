import React from "react"
import PropTypes from "prop-types"
import BootstrapTable from 'react-bootstrap-table-next';

class BookShareTable extends React.Component {

  convertDataObj(obj) {
    return {book: obj[this.props.book]};
  }

  render() {
    const idColumn = {
      dataField: 'book.key',
      text: 'Ignored',
      hidden: true
    };
    const data = this.props.data.map((obj) => this.convertDataObj(obj));

    const columns = [idColumn];
    return(<BootstrapTable
        keyField='book.key'
        data={data}
        columns = {columns}
      />);
  }
}

BookShareTable.propTypes = {
  caption: PropTypes.string.isRequired,
  book: PropTypes.string.isRequired,
  data: PropTypes.array.isRequired
};

export const utils = {

  test: function() {
    return 1;
  }
}
export default BookShareTable;
