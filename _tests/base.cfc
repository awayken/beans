component extends="mxunit.framework.testcase" {
    
    function testSimpleInit() {
        var data = {
            name = "Fake name",
            value = "Fake value",
            extraProperty = "Fake property"
        };
        var bean = new simplebean( argumentCollection=data );
        
        assertEquals( bean.getName(), data.name );
        assertEquals( bean.getValue(), data.value );
        assertFalse( isDefined('bean.getextraproperty'), 'extraProperty should not have a getter' );
        assertFalse( isDefined('bean.setextraproperty'), 'extraProperty should not have a setter' );
        assertFalse( isDefined('bean.extraproperty'), 'extraProperty should not have a value' );
    }
    
    function testComplicatedInit() {
        var data = {
            testString = "Fake name",
            testNumeric = 10,
            testBoolean = true,
            testDate = now(),
            testArray = [ 1, 2, 3, 4 ],
            testStruct = {
                a = 1,
                b = 2,
                c = 3
            },
            testQuery = queryNew('ID, Name, Numbers', 'integer, varchar, integer'),
            testObject = new simplebean( name='Fake name' )
        };
        var bean = new complicatedbean( argumentCollection=data );
        
        assertEquals( bean.gettestString(), data.testString );
        assertEquals( bean.gettestNumeric(), data.testNumeric );
        assertEquals( bean.gettestBoolean(), data.testBoolean );
        assertEquals( bean.gettestDate(), data.testDate );
        assertEquals( bean.gettestArray(), data.testArray );
        assertEquals( bean.gettestStruct(), data.testStruct );
        assertEquals( bean.gettestQuery(), data.testQuery );
        assertEquals( bean.gettestObject().getName(), 'Fake name' );
    }
    
}