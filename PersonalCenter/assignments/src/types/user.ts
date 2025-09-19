export interface User {
    name: string;
    email: string;
    pass: string;
    checkPass: string;
    realName: string;
    sex: string;
    img: string;
    phone: string;          
    office: string;         
    officeAdress: string;   
    desc: string;
}

export interface UserForm {
    name: string;
    email: string;
    pass: string;
    checkPass: string;
    realName: string;
    sex: string;
    fileList: File[];
}

export function mapToUser(userData: any): User {
    return {
      name: userData.userName || '',
      email: userData.email || '',
      pass: userData.password || '',
      checkPass: '',
      realName: userData.realName || '',
      sex: userData.gender === 1 ? 'Male' : 'Female',  
      img: userData.img || '',
      phone: userData.phone || '',
      office: userData.office || '',
      officeAdress: userData.officeAdress || '',
      desc: userData.desc || '',  
    };
}