import React, { useState } from 'react';
import { SafeAreaView, View, Text, StyleSheet, Button, FlatList, Dimensions, Image, Screen, Modal } from 'react-native';
import { TouchableOpacity } from 'react-native-gesture-handler';
import ButtonTile from '../components/ButtonTile';
import Storage from '../model/Storage';

const data = [
    {key: 1, title: 'coom'},{key: 2, title: 'bum'},{key: 3, title: 'poo'},{key: 4, title: 'poops'},{key: 5, title: 'poo'},{key: 6, title: 'poo'},{key: 7, title: 'poo'},{key: 8, title: 'poo'},{key: 9, title: 'poo'},{key: 10, title: 'poo'},{key: 11, title: 'poo'},{key: 12, title: 'poo'},{key: 13, title: 'poo'},{key: 14, title: 'poo'},{key: 15, title: 'poo'},{key: 16, title: 'poo'},
];

// const data = [
//     { key: 'A' }, { key: 'B' }, { key: 'C' }, { key: 'D' }, { key: 'E' }, { key: 'F' }, { key: 'G' }, { key: 'H' }, { key: 'I' }, { key: 'J' },
//     // { key: 'K' },
//     // { key: 'L' },
//   ];
  
  const formatData = (data, numColumns) => {
    const numberOfFullRows = Math.floor(data.length / numColumns);
  
    let numberOfElementsLastRow = data.length - (numberOfFullRows * numColumns);
    while (numberOfElementsLastRow !== numColumns && numberOfElementsLastRow !== 0) {
      data.push({ key: `blank-${numberOfElementsLastRow}`, empty: true });
      numberOfElementsLastRow++;
    }
  
    return data;
  };

  const headerButtonPress = () => {
    alert('This is a button!')
  }
  
  const numColumns = 3;
  class HomeScreen extends React.Component {
    static navigationOptions = {
      headerTitle: () => <Text style={styles.headerTitle}>Click.</Text>,
      headerRight: () => (
        
        <TouchableOpacity onPress={headerButtonPress}>
          <Text style={styles.headerBtn}>+</Text>
        </TouchableOpacity>
      ),
    };

    renderItem = ({ item, index }) => {
      if (item.empty === true) {
        return <View style={[styles.item, styles.itemInvisible]} />;
      }
      return (
        // <View
        //   style={styles.item}
        // >
        //   <Text style={styles.itemText}>{item.title}</Text>
        // </View>
        
        <View style={styles.item}>
            <ButtonTile 
                style={styles.item}
                title={item.title}
            />
        </View>
      );
    };
  
    renderButtonList() {
      return(
        <FlatList
          data={formatData(data, numColumns)}
          style={styles.container}
          renderItem={this.renderItem}
          numColumns={numColumns}
        />
      )
    }

    render() {
      return (
        <View style={styles.mainContainer}>
         <View style={styles.mainContainer}>
         {this.renderButtonList()}
         </View>
          <Modal 
            transparent={true}
            visible={true}
            >
            <Text>Modal!</Text>
          </Modal>

        </View>
      );
    }

  }
  
  const styles = StyleSheet.create({
    mainContainer: {
      flex: 1,
      backgroundColor: 'blue',
      justifyContent: 'center',
  },
    container: {
      flex: 1,
      marginVertical: 5,
      marginHorizontal: 5,
    },
    item: {
      backgroundColor: 'transparent',
      alignItems: 'center',
      justifyContent: 'center',
      flex: 1,
      margin: 1,
      height: Dimensions.get('window').width / numColumns, // approximate a square
    },
    itemInvisible: {
      backgroundColor: 'transparent',
    },
    itemText: {
      color: '#fff',
    },
    headerBtn: {
      fontSize: 25,
      color: 'black',
      paddingRight: 20,
    },
    headerTitle: {
      fontSize: 25,
      color: 'black',
    },
    modal: {
      flex: 1,
      alignItems: 'center',
      backgroundColor: '#00ff00',
      padding: 100,
    },
  });

  export default HomeScreen;