using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Linq;
using UnityEngine.XR.ARFoundation;   //忘れないように
using UnityEngine.XR.ARSubsystems;   //忘れないように

[RequireComponent(typeof(ARRaycastManager))]
public class ObjectDeployer : MonoBehaviour
{
    [SerializeField] GameObject _objPrefab;
    
    private ARRaycastManager _raycastManager;
    private List<ARRaycastHit> hits = new List<ARRaycastHit>();



    void Start()
    {
        _raycastManager  = GetComponent<ARRaycastManager>();
    }

    void Update()
    {
       if(Input.GetMouseButtonDown(0))
       {
           if(_raycastManager.Raycast(Input.GetTouch(0).position, hits, TrackableType.All))
           {
               Vector3 pos = new Vector3(hits[hits.Count - 1].pose.position.x, 
               hits[hits.Count - 1].pose.position.y+_objPrefab.transform.position.y, 
               hits[hits.Count - 1].pose.position.z);

            /*
               //Linqを使用してわかりやすく書く場合はこっち
               Vector3 pos = new Vector3(hits.Last().pose.position.x, 
               hits.Last().pose.position.y+_objPrefab.transform.position.y, 
               hits.Last().pose.position.z);
            */

               Instantiate(_objPrefab, pos, Quaternion.identity);
           }
       } 
    }
}
