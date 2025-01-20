import styles from "./page.module.scss";
import UserList from "@/components/UserList/UserList";

export default function Home() {
  return (
    <div className={styles.page}>
      <main className={styles.main}>
        <UserList />
      </main>
    </div>
  );
}