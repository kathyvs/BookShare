import React from "react"
import PropTypes from "prop-types"
import BootstrapTable from 'react-bootstrap-table-next';

class BookShareTable extends React.Component {

  render() {
    return(<BootstrapTable data={this.props.data}/>);
  }
}

BookShareTable.propTypes = {
  caption: PropTypes.string.isRequired,
  data: PropTypes.array.isRequired
};
export default BookShareTable
