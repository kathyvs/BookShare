import React from "react"
import PropTypes from "prop-types"
import BootstrapTable from 'react-bootstrap-table-next';

class BookShareTable extends React.Component {

  convertDataObj(converters, obj) {
    return {book: obj[this.props.book]};
  }

  processColumns(columns) {
    const idColumn = {
      dataField: 'book.key',
      text: 'Ignored',
      hidden: true
    };
    const result = {
      converters: [],
      columns: []
    };
    columns.forEach((column) => {
      if ('extractBy' in column) {
        const newColumn = Object.assign({}, column);
        delete newColumn.extractBy;
        result.converters.push({extractBy: column.extractBy, dataField: column.dataField})
        result.columns.push(newColumn);
      } else {
        result.columns.push(column);
      }
    });
    result.columns.push(idColumn);
    return result;
  }

  render() {
    const processedColumns = this.processColumns(this.props.columns);
    const data = this.props.data.map((obj) => this.convertDataObj(processedColumns.converters, obj));
    return(<BootstrapTable
        keyField='book.key'
        data={data}
        columns = {processedColumns.columns}
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
